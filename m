Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF54AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 09:36:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B2C40662;
	Fri,  6 Jun 2025 11:36:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by mails.dpdk.org (Postfix) with ESMTP id 56D8840265
 for <dev@dpdk.org>; Fri,  6 Jun 2025 11:36:19 +0200 (CEST)
Received: from DESKTOP-P620.suse.de (unknown [IPv6:2a07:de40:b2bf:1b::106b])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9E3801F7A6;
 Fri,  6 Jun 2025 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1749202579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lHkwfDZeJ0hBPukcqX9vuwZ9d67sFPuz9CxYLY7Qy78=;
 b=YJH5enezYVCGgbvh1f+3ryl8jYvWX7NKyWBB12rlHyTSUAZpyuf6euyxZrv0WvLJGeB0oP
 WoA8ezuXtmi82Xu09ZjYpNwZZrt2sh3QZELyaCt3A4cCnSv13n5A0QnqtWjTvLQ5vrupJ7
 01DRIvZql2DyDJSEypm+e+i2/8YXJPw=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=LaKBMrlm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1749202578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lHkwfDZeJ0hBPukcqX9vuwZ9d67sFPuz9CxYLY7Qy78=;
 b=LaKBMrlmym0aNfLaU88EUIl9O3RMnJT3a+Umm/l5GEvXcrnCcr1s09HAjEa0k/4Sq1YRC4
 Lw5vk96tWymWXyiiagHpbGpHGS1aJQvaPV92pHiVh7DdbLalG8LSeDNqGNJGH5eetiz1Bo
 n0xAqG60rEt8I2m8HdYmYZTece5eZWc=
From: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
To: paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Clemens Famulla-Conrad <cfamullaconrad@suse.com>
Subject: [PATCH 1/1] dts: fix deterministic doc
Date: Fri,  6 Jun 2025 11:35:02 +0200
Message-ID: <20250606093502.31767-1-cfamullaconrad@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.01 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[]; MID_CONTAINS_FROM(1.00)[];
 HFILTER_HELO_IP_A(1.00)[desktop-p620.suse.de];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[desktop-p620.suse.de];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; DIRECT_TO_MX(0.00)[git-send-email 2.43.0];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::106b:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 RCVD_COUNT_ZERO(0.00)[0];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bu.edu:email,intel.com:email,DESKTOP-P620.suse.de:helo,zte.com.cn:email,suse.com:dkim,suse.com:mid,suse.com:email];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::106b:from];
 RCPT_COUNT_THREE(0.00)[3]
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 9E3801F7A6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
index 66a77da9c4..c1e4a898d4 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -70,7 +70,7 @@ def send_packets_and_capture(
         receive_port: Port,
         filter_config: PacketFilteringConfig,
         duration: float,
-        capture_name: str = _get_default_capture_name(),
+        capture_name: str = None,
     ) -> list[Packet]:
         """Send `packets` and capture received traffic.
 
@@ -104,6 +104,9 @@ def send_packets_and_capture(
             duration,
         )
 
+        if capture_name is None:
+            capture_name = _get_default_capture_name()
+
         self._logger.debug(f"Received packets: {get_packet_summaries(received_packets)}")
         self._write_capture_from_packets(capture_name, received_packets)
         return received_packets
-- 
2.43.0

