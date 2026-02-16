Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81380E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C124068E;
	Mon, 16 Feb 2026 22:43:32 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 486704067B
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:31 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4362197d174so2415829f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278211;
 x=1771883011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hp2IaC5tocVcEm0SVcdrxYyL1X1zM/xlGZa6HMzMdtg=;
 b=z8C0GN98B+TsqUtkVWXYRLtkLqOYLkRjKZfgHEUa93PbzLcvcUp7eLkFX+dk+AUrGG
 iY6wFaJja3ip7sZz0+R+04BYMoGUFxpY06dSzdKIp3wzzcp4tBJ9Q1bD6vvJiqFnGKke
 HsuXLRMst7o8j/lqpq3vN0Kn4+LadzyVbIJ50/jACx0X1fWMgSvxgR1fCGX+Acopvvf8
 z866lDq7ihGaJl5WE5jD3k97xaPEh+vP+moOY22ZL1TV7BlBNrcz0ClNWOojAWBGrim4
 HEYqWA1ox0gei3lK+PdtJowE3r2hYnD5hKHI/msamhSZyqZO5RmJtOv+nojpZaV0GOXJ
 ubww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278211; x=1771883011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hp2IaC5tocVcEm0SVcdrxYyL1X1zM/xlGZa6HMzMdtg=;
 b=xH15bjvb1aGQ3y0jv3F06tfjl0+Qa/SjyLOshH/83P5XrtGQpfK8yawQTnE+mZRMgB
 dOouDtP4gBR725BUoWizFZb3Z8vx1BXUUZCGQdlNiIQWzCwgIJOMokbvpnIzfKl6n8sA
 T0F7aAcOYYxsHtC5xWNSZHUZBhilYy0LhRTSh93YO5nh9xuZAnK2aHoO/LZZwmPKMQjF
 6CR6qrTndg4Q/RCz2nFlytZT6RTqiBoRDfikSP4tcEyc/AbKy9YJOQqCHrtzBoIQ88Ye
 mKlEVhoXkxrVjvtZzJ81TfgoTpxbs0kbnDtOtMcSheASAs5+A0GjxLdJpfMdjyYlTRcn
 y+HQ==
X-Gm-Message-State: AOJu0YyXw8keEKokMqlbB21NGSDeJxIGzb7GNyy0voGj5KPg2ukKo01w
 OTkSQ76zlTWdTlw2dOmJx6vDnQTQZvr8wt+1fKlC9zcrtwUac+UD0MLjRq2dpevaZdm/1VxjWZ6
 4OPNMdr4=
X-Gm-Gg: AZuq6aKMyl0EPEi8TubSUunQpR3rQGbvCrnQaeW1swXWBreRvUYIG5YevXKbD5HkD6+
 LsAMRVqTJz5OMLjaTyfr9ql7HAuhUdKRY0B6ywEZWUpnp4HYvh1B/yWHUB+tzlQqYOScXfkWVHk
 ZFQpGaSpOI17+G7XDvZVc0xYGDOMY1K9cdgNG7w39J/aAWMPJV0cBxrCdH8WJm2xJkpIm5YccFQ
 ZvSG8+qg8+7NAlbicuqhPjf+orIHYqxdVujvdoRDMHmi+UtML17kcmxzGd8XE62TPVm7KsH3ZbB
 hc7SAk8NEfV9qImxVQmNPIj9Vi7i0/tue/xwQMrMZOmpnxBvZwzi/8IV3TfW25B9iImh8yGgOmJ
 +FFo/lW9+ULcFl9im294vaE0++CQgJoMrAbsFchew49pibCg+NMk+/8BkdwJTppnCO5Cr9GbGRj
 LlDPUtHJNUZHswPXaAvURl6OjPrcPyC4wjuvsywiQyyFZOOYN6Ohu59WjX8strAA==
X-Received: by 2002:a05:6000:2011:b0:431:9d7:5c2e with SMTP id
 ffacd0b85a97d-4379790e670mr23265308f8f.35.1771278210871; 
 Mon, 16 Feb 2026 13:43:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v8 7/8] test/pcapng: skip test if null driver missing
Date: Mon, 16 Feb 2026 13:38:04 -0800
Message-ID: <20260216214311.717492-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
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

The pcapng test requires the net_null driver to create a virtual
device. If the null driver is excluded from the build, the test
fails with:

 RTE>>pcapng_autotest
  + ------------------------------------------------------- +
  + Test Suite : Test Pcapng Unit Test Suite
 Failed to create vdev 'net_null0'

Add net_null to the meson build dependency list for the test so
that it is automatically skipped when the driver is not available.

Fixes: 0c614a0fa6c6 ("test/pcapng: cleanup")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 48874037eb..4fd8670e05 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -135,7 +135,7 @@ source_file_deps = {
     'test_mp_secondary.c': ['hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
-    'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
+    'test_pcapng.c': ['net_null', 'net', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
-- 
2.51.0

