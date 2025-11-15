Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE47CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C587A42708;
	Sat, 15 Nov 2025 20:37:59 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id CCF5840EE1
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:37:55 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b99bfb451e5so1902510a12.2
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235475;
 x=1763840275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmIClxqFhfCIQ1Hg18UKnrZUnKoynOBU8gebt0uOAPo=;
 b=z5K+pGsxS3qDzWQAr/fzoKEVB5RnrBH07JH5dfjvKxV7Ze1nge6WnDVib5eZlsqNu8
 I0fJrHfEkAQi3s5seAy1HL/zOs/V2y6v++ni9iLlTcLoI5FJps27ifCYf1cTwyua4oFJ
 zly6hllWmscZpVzplvrJq5zxCwUQiYSkUbVYXB8bpslwZzRHJJk4lL6JNNJqR+p3y4NL
 laKV80ZpHstudJbINe/AT/fCe6p1BRMQQHvqD86K/POSH7FRwTNSSwJWWx3J1Tru0oXM
 WKTAv1HbLI5tSE6vV4weZ1ddjxF1hBn59YQCKBxnurL2zjxnlaBrJLgATjKIM3bRoAQy
 ypSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235475; x=1763840275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UmIClxqFhfCIQ1Hg18UKnrZUnKoynOBU8gebt0uOAPo=;
 b=lNW1gbsT9wviQVfEmq0J20yvDbJPrmnaEVA2ti/3JqtmtlBtpz733YWEYA5hZBw2d5
 IBLl2WuSgr4vm5tRCI4gjtSz+FrczZ4c/G4KXRyyq/cIp9J06Y9FcUS0+2hZkDKqm3Fc
 5iDfOYq9A+JpDE+gGCGbdt9fUMfMx1eWqDMdSSAfYCUV63wYMbNHDvb8t38eK5jLT2yF
 Aj2xOmQX039KC47551tdQpCSbPMPMBKTQpYZJTkpAPv6zfalJzq/BPpfsj5FtDIgRR5p
 uix2TiU0t1MJGiBDNA8SIHg3qTaPnwUtcufywGLEUEpXzOdu67NVjJK16Q8B4lAr3TAh
 +gSw==
X-Gm-Message-State: AOJu0YydkhrUVOzf6FI/4ipSWMyNfqeQ4lH303efs/8Quczpg6fpigBi
 B52rf4dihpgWt5ZiV3mv52ncreOOyQNMKR8+F4iOlInC6huGoGorDsPEf+zUV3JlGV8BWO6naJl
 HDozC
X-Gm-Gg: ASbGncvrNg/ZSaaQ7mUMTZtUuripitBAL3pW3u2ZphNPJap71ejmTobZFeCLz5TqJkB
 HcNXECNpubQNJYGYgmcNS9faigqRbFJ4ZE+5YqkAU4bf19E5mbORhXW4HmD+nhwGlEfGumwjmOa
 j432AElNyoUeUoauKqBBFyYr06FIsefQp418L6wdt4D5p0fGgcXR7oybNsVBm07LLfoWvcllle3
 cCND3835wZ2DMMFcNNVi/LoynHLve+KKN91Qxuy1GHESc9cEuULyQYqcaNVmqxmBXrm2CAznN1Q
 KHoePl5GUJgBo8OGO1ioLweyRkwTuHM4qX/bMKBPDq18M6IItT2zL7HnzVPPDvzs7oGAzE+5W6P
 1XxUqgdtzBgmoyYdpMwwhI0ctxamxUr6hkas0Ra2bqXm+SYMjcSzEtyO5JBSwAyfqBzIDazzlyO
 rFmNLLzwVh3YvupnaB90WP8dRcoPPUzIbkcTgZi6a703FDjDiuNZjv408XXqko
X-Google-Smtp-Source: AGHT+IErmB9BDEhLpDomkveQq/vvz55A3sLE+kj5WZ3VvMwxcPuPeuEcDvXuWLxje49buhcqImEODA==
X-Received: by 2002:a05:7300:5708:b0:2a4:3592:c611 with SMTP id
 5a478bee46e88-2a4abd6dd8amr3141985eec.34.1763235474910; 
 Sat, 15 Nov 2025 11:37:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm28753833eec.0.2025.11.15.11.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:37:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, maxime.coquelin@redhat.com,
 stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/4] examples/vdpa: fix format overflow warning
Date: Sat, 15 Nov 2025 11:36:37 -0800
Message-ID: <20251115193749.101355-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193749.101355-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ifname is limited to 128 characters, but it would allow up
to 128 characters as prefix then could overflow creating ifname.

Change to limit path prefix (iface) to 123 (128 - sizeof("1024"))
to avoid possible format overflow

../examples/vdpa/main.c:501:76: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  501 |                         snprintf(vports[devcnt].ifname, MAX_PATH_LEN, "%s%d",
      |                                                                            ^
../examples/vdpa/main.c:501:25: note: ‘snprintf’ output between 2 and 139 bytes into a destination of size 128
  501 |                         snprintf(vports[devcnt].ifname, MAX_PATH_LEN, "%s%d",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  502 |                                         iface, devcnt);
      |

Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")
Cc: maxime.coquelin@redhat.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vdpa/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 289db26498..7fd0e55b20 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -22,6 +22,8 @@
 
 #define MAX_PATH_LEN 128
 #define MAX_VDPA_SAMPLE_PORTS 1024
+#define stringify(x) (#x)
+#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))
 #define RTE_LOGTYPE_VDPA RTE_LOGTYPE_USER1
 
 struct vdpa_port {
@@ -36,7 +38,7 @@ struct vdpa_port {
 
 static struct vdpa_port vports[MAX_VDPA_SAMPLE_PORTS];
 
-static char iface[MAX_PATH_LEN];
+static char iface[MAX_PATH_LEN - MAX_VDPA_STR_LEN];
 static int devcnt;
 static int interactive;
 static int client_mode;
@@ -74,9 +76,8 @@ parse_args(int argc, char **argv)
 			break;
 		/* long options */
 		case 0:
-			if (strncmp(long_option[idx].name, "iface",
-						MAX_PATH_LEN) == 0) {
-				rte_strscpy(iface, optarg, MAX_PATH_LEN);
+			if (!strcmp(long_option[idx].name, "iface")) {
+				rte_strscpy(iface, optarg, sizeof(iface));
 				printf("iface %s\n", iface);
 			}
 			if (!strcmp(long_option[idx].name, "interactive")) {
-- 
2.51.0

