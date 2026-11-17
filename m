Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF565606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fcasQTS/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A3F0402E0;
	Tue, 17 Nov 2026 17:07:42 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 59AC840682
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:07:38 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8b58d6f67a5so2401322b3a.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794931657;
 x=1795536457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kyV9+jKG/IXDS1fztAWITMwz9pBI0G5fLaj9qBds8VE=;
 b=fcasQTS/MMw1xVi6xqe564DM5KhU5WNAr0pl57doS3L5ddD9U8UcnDmzth4H0wwFL4
 Ckw8A0CpOw0F76cEFFlsMDNyzwMPT3H6MU4jBOIRcdGfN9h9oAA9DTMT+tWvru+jwUho
 8BHeLQK4lJ3ZARLejVTq8DIvoUik07pd3FtCUDK4W5TZ93bd0txu7bTwJsnuzr9lwupI
 zXX7+2eyevRhEqHKUlkMeuafKPxkF8Chjwu3CQl2smkpjX4AaRvR+y6lJ/nCRBoT9/Fv
 Uf5pUbGu/rUNaGVk4pydpLXNmDuIG1DQhooC58Qu0yEcBYYN+u6fx5tMOa+3/uX7wlK7
 cYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931657; x=1795536457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kyV9+jKG/IXDS1fztAWITMwz9pBI0G5fLaj9qBds8VE=;
 b=BLgXiWpCdtehJFLEyWnxxO0rFPJ5toT+wZ1SHDrQMmHinUYdy/mlc3VA4+wZ2NP7gx
 ThjbNhAgYKRVtz1AU8zuLwsZ7uVqAGPmcS01+zYCVKYuMzvt3+qyEv05AtyTfjd63c2n
 Ep4pZ3NH+IgtzuQ0dLVnN7o9wsthZHW4I63K4DcE0ddevWl1LWE1LLGotRIv6zOuvQOE
 L0nY/prPpxE7IJD3a366qb7Xgeu27kOnx+V8jJ8/MAKTkE6Gt7c1yJfl6CEe1NomUEtB
 9ZsDig4cd8MJGAfUDC6B63hPWR7/BEN50pPwmQvyNqruXHccsdUUEGdhvaParGNSd7pK
 KPTA==
X-Gm-Message-State: APuU4Z876D3hK85Y3aDMfoNLWk0AHFBc4HvUptWuNfkqjXVpimWUH8ux
 sAn6RrXH0nNRpF4kXyd7m8f7YEChRlTt0Tg9vSOO/UzQwYy2spSqgvfiCKCxRGauPfRMlPXCbSh
 k+r0jVz0=
X-Gm-Gg: AYBFou0s+hXLnLQ7T9DkteDMCN8xdF+jzIHGzosIaPxQ80DKZqDhgzZl20pubLUk4Pg
 nzb20zLvf5gyR2FSTdsTJbG04CBbd/W0fHwDNS3hcB8ppG0Wnh+8a+4xmLj0ihNRPRHCpkn50M4
 KUd3lwwG4gF5eNeEzAn06rQ1KuO2JEqWtnZ3SoigL67m5DiaOPvTAyqzb0PkmYTB9P0GfGGhKat
 bX2KY7Md0WbldYLN4OnkEfbzncdHK8Q8g9OX1orKUp7cImuWB+pIjrDlVlZdNz8FMznJHiku8uo
 ktE1uVvlHkpuHBavLVTugJIch6ercv7LUVfc97u8TaPm664nsZaGmdbBFX/+Guyjz7yWEfheJ0L
 0P0q3V4HSxjrYXU6YdYvPBVR96HtFU+dHGIYM4Zkdw9vb1ST7lnaKi0TxoNbhpqDl4q/cJBxKVI
 x+2awSQTI8hsp19syXGrqj3FLLVhUf6KqpQsXEYvKCEVQbqkMxVPRyDTfUjSDC8rEeLlgowmTcG
 PrW230nFwvl8yFVS3vMimSFORkfv4bHzZgJds+co9NoO0xS7U2brxw4k1eC+lEdzO3x6CgqoPf5
 mUcZBLyXpbN1HF8tZz5p3Tn+8EVKofU22mJuru/x6DvT8FZ+QcJYikJwMOki5H0H/H0o1oA=
X-Received: by 2002:a05:6a00:908e:b0:8b2:12b4:44fc with SMTP id
 d2e1a72fcca58-8beb658dec8mr13438861b3a.30.1794931656589; 
 Tue, 17 Nov 2026 08:07:36 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5b40c3d33sm9403b3a.49.2026.11.17.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:07:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 4/4] app/dumpcap: do not use rte_exit before EAL init
Date: Tue, 17 Nov 2026 08:06:22 -0800
Message-ID: <20261117160727.388470-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117160727.388470-1-stephen@networkplumber.org>
References: <20261117160727.388470-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Errors in command line options and in setting up the EAL arguments
were reported with rte_exit() or rte_panic(), which call EAL cleanup
or dump EAL state before EAL has been initialized.

Use a simple helper which prints the message and exits instead.

Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 57 +++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 1f9f03c7a3..49979fbf37 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <signal.h>
+#include <stdarg.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -163,6 +164,22 @@ static const char *version(void)
 	return str;
 }
 
+/*
+ * Exit with error message, for errors before EAL is initialized
+ * where rte_exit() can not be used.
+ */
+static __rte_noreturn __rte_format_printf(1, 2)
+void early_exit(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+
+	exit(EXIT_FAILURE);
+}
+
 /* Parse numeric argument from command line */
 static unsigned long get_uint(const char *arg, const char *name,
 			     unsigned int limit)
@@ -172,13 +189,11 @@ static unsigned long get_uint(const char *arg, const char *name,
 
 	u = strtoul(arg, &endp, 0);
 	if (*arg == '\0' || *endp != '\0')
-		rte_exit(EXIT_FAILURE,
-			 "Specified %s \"%s\" is not a valid number\n",
-			 name, arg);
+		early_exit("Specified %s \"%s\" is not a valid number\n",
+			   name, arg);
 	if (limit && u > limit)
-		rte_exit(EXIT_FAILURE,
-			 "Specified %s \"%s\" is too large (greater than %u)\n",
-			 name, arg, limit);
+		early_exit("Specified %s \"%s\" is too large (greater than %u)\n",
+			   name, arg, limit);
 
 	return u;
 }
@@ -190,24 +205,21 @@ static void auto_stop(char *opt)
 
 	value = strchr(opt, ':');
 	if (value == NULL)
-		rte_exit(EXIT_FAILURE,
-			 "Missing colon in auto stop parameter\n");
+		early_exit("Missing colon in auto stop parameter\n");
 
 	*value++ = '\0';
 	if (strcmp(opt, "duration") == 0) {
 		double interval = strtod(value, &endp);
 
 		if (*value == '\0' || *endp != '\0' || interval <= 0)
-			rte_exit(EXIT_FAILURE,
-				 "Invalid duration \"%s\"\n", value);
+			early_exit("Invalid duration \"%s\"\n", value);
 		stop.duration = interval;
 	} else if (strcmp(opt, "filesize") == 0) {
 		stop.size = get_uint(value, "filesize", 0) * 1024;
 	} else if (strcmp(opt, "packets") == 0) {
 		stop.packets = get_uint(value, "packets", 0);
 	} else {
-		rte_exit(EXIT_FAILURE,
-			 "Unknown autostop parameter \"%s\"\n", opt);
+		early_exit("Unknown autostop parameter \"%s\"\n", opt);
 	}
 }
 
@@ -217,11 +229,11 @@ static struct interface *add_interface(const char *name)
 	struct interface *intf;
 
 	if (strlen(name) >= RTE_ETH_NAME_MAX_LEN)
-		rte_exit(EXIT_FAILURE, "invalid name for interface: '%s'\n", name);
+		early_exit("invalid name for interface: '%s'\n", name);
 
 	intf = malloc(sizeof(*intf));
 	if (!intf)
-		rte_exit(EXIT_FAILURE, "no memory for interface\n");
+		early_exit("no memory for interface\n");
 
 	memset(intf, 0, sizeof(*intf));
 	rte_strscpy(intf->name, name, sizeof(intf->name));
@@ -381,13 +393,11 @@ static void parse_opts(int argc, char **argv)
 				tmp_dir = optarg;
 			} else if (!strcmp(longopt, "ifdescr")) {
 				if (last_intf == NULL)
-					rte_exit(EXIT_FAILURE,
-						 "--ifdescr must be specified after a -i option\n");
+					early_exit("--ifdescr must be specified after a -i option\n");
 				last_intf->ifdescr = optarg;
 			} else if (!strcmp(longopt, "ifname")) {
 				if (last_intf == NULL)
-					rte_exit(EXIT_FAILURE,
-						 "--ifname must be specified after a -i option\n");
+					early_exit("--ifname must be specified after a -i option\n");
 				last_intf->ifname = optarg;
 			} else {
 				usage();
@@ -399,8 +409,7 @@ static void parse_opts(int argc, char **argv)
 			auto_stop(optarg);
 			break;
 		case 'b':
-			rte_exit(EXIT_FAILURE,
-				 "multiple files not implemented\n");
+			early_exit("multiple files not implemented\n");
 			break;
 		case 'c':
 			stop.packets = get_uint(optarg, "packet_count", 0);
@@ -629,7 +638,7 @@ static void dpdk_init(void)
 	/* DPDK API requires mutable versions of command line arguments. */
 	eal_argv = calloc(eal_argc + 1, sizeof(char *));
 	if (eal_argv == NULL)
-		rte_panic("No memory\n");
+		early_exit("No memory\n");
 
 	eal_argv[0] = strdup(progname);
 	for (i = 1; i < RTE_DIM(args); i++)
@@ -647,7 +656,7 @@ static void dpdk_init(void)
 
 	for (i = 0; i < (unsigned int)eal_argc; i++) {
 		if (eal_argv[i] == NULL)
-			rte_panic("No memory\n");
+			early_exit("No memory\n");
 	}
 
 	/*
@@ -656,10 +665,10 @@ static void dpdk_init(void)
 	 */
 	if (lcore_arg == NULL &&
 	    rte_thread_get_affinity_by_id(rte_thread_self(), &cpuset) != 0)
-		rte_panic("rte_thread_getaffinity failed\n");
+		early_exit("rte_thread_getaffinity failed\n");
 
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
-		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
+		early_exit("EAL init failed: is primary process running?\n");
 
 	/*
 	 * Register pdump callback handler.
-- 
2.53.0

