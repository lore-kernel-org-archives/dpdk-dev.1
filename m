Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EF106ACE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716EF4060B;
	Thu, 12 Mar 2026 21:36:34 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9B18040275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:36:32 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8cd7aab92dfso180045285a.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773347792; x=1773952592; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ru8OYAnu7xQ8MTTp/UmJQn06AADhCRfqdyfFX3B3jA0=;
 b=WspNeSO/quvuPgUT+sforIfRpKi6eCXM9QAcxR2HaAV6Hcw9VfjJfi9wPCvWkR1OVw
 wrpNQWWkWCxcvgEZqDXP2QBy9CPrmkdjZCR3BX+gbddkEavBlNQqkvpNIiIT5l9RRJni
 NnERyQ/sOhtwfBrWjAr3MfYCRrx0wfk1n4RRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347792; x=1773952592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru8OYAnu7xQ8MTTp/UmJQn06AADhCRfqdyfFX3B3jA0=;
 b=YJTiqYUtttaRgplixxFq6ukegNQJXPqtn7eNSI/Vh9QMfDSee7Akn4J93aigtYiIiy
 825vDuKcfVsCPOeG5N2215ep1R4eoO8KrL4Ptv89gNAqdJSaVoh6ryJumATY8Lh1WON6
 BTpmhxkCxRR5d0K2GFcta5x8fIUOFTgvPrXXQekGZa5emrq8K4Ts2TS5eiMViai5NZA3
 8oZNmiRYq/gsopkiav1/rNWKIB7TctKsjiEJzVVz6bGG63E09L9j77+Tt2PdOGXQFkbS
 RNxSOwDHDt+M91xyPCOEAub727gA0j7bpUfWu53zOlPaNp97cwl1IrKSc30SMjdjbgn/
 EDqA==
X-Gm-Message-State: AOJu0YwjDx6rlFzXS8olVPwwPHKPmzHAU5rq+piXqZdJ8oxStrenVRJA
 god9UtdJlvX6WqNt8hVjNv4QFMkBm0kVYQzfHoHVVzivMgiPu4rEB22BzCdcCyTbGY8=
X-Gm-Gg: ATEYQzwmpcEF9ntJyrrXkX+Im2uqAVlX4gVGIbBuImUWel7sXvzE4piyNc0YTWfQlZn
 TmUKfjCnHvgSm+vWyoYrJYtpf1KwESczx0GsVpw92w2a6ceFi88UoVfi1tSRQeSahjo+SHuL36+
 JHoAxfm8Ge/gV59F4hDpVbLpa2fp1TN2+d3AXkAufAbLpchXCFkQi1X1SetWEJmOKNlLHt5KWeo
 k4mJHrt/Xgygw63ZDpfCqolhofgEiR8+mdlHDeagvLAfVq/1qo+qmQNC3+Le6qgcfC1Uooi+ws1
 hhuiVq1ui6j69a1fYMdGmmGemX/yyMxzn8Y1XJP2o5QUM38/C2NL8Pym8VU0/Y5u4GTBtO7Gn0z
 iFYL1spoa7gnBktBQWnnKxLCMJj+UwNq15TEiQMB+6nPQOiXwf3dXv8AXkt3RCsnYfNFLZXFVlZ
 0xvnzK6AHzmGvcgOSNlQg7bPlr3OGzY7aHfxLVWbunBTml+9BydzYdJ0IF9KNKtg==
X-Received: by 2002:a05:620a:2910:b0:8cd:8783:49d4 with SMTP id
 af79cd13be357-8cdaa84c033mr556046185a.26.1773347791961; 
 Thu, 12 Mar 2026 13:36:31 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda2173217sm493234385a.51.2026.03.12.13.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:36:31 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: update verbose output regex for VXLAN packets
Date: Thu, 12 Mar 2026 16:36:29 -0400
Message-ID: <20260312203630.96473-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
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

The packet regex in extract_verbose_output could not
match verbose output from tunnel protocols like
VXLAN because it did not allow commas. VXLAN
verbose lines contain comma-separated fields,
which caused the regex to fail before reaching
the final field. This silently dropped the entire
packet from the parsed output. Added comma and
dot to the allowed characters in the regex.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/testpmd/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 703cae487e..bbcec7f969 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -817,7 +817,7 @@ def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket]:
         prev_header: str = ""
         iter = re.finditer(
             r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+ packets)?)\s*"
-            r"(?P<PACKET>src=[\w\s=:-]+?ol_flags: [\w ]+)",
+            r"(?P<PACKET>src=[\w\s=:,.-]+?ol_flags: [\w ]+)",
             output,
         )
         for match in iter:
-- 
2.52.0

