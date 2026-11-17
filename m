Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F90606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ka8GOvF9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89227402EB;
	Tue, 17 Nov 2026 17:07:37 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 1EC5040A7D
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:07:35 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a9f9473029so4485560b3a.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794931653;
 x=1795536453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTxkm52SwyWAxOw4MUfMiPQp1u3bD0l95fJGtaKJ6LY=;
 b=ka8GOvF9E1UuG0xgADydct3dAKaJOnwFuusjheAetnGBwbnOlZSeIsKXN3UlioXOaO
 ZwgWl9PbF11AntYp4rSKl3BNX+asRWhAOhF9A0Y20Pp09EMa5oRCfV3SEYAcA7QUgEDJ
 z2vF5edPncG8iN5ATwzs2d/XjwdjHiewLv79NrU4Jn3xFcQgitiq+wfWJ3IXurTaYk2y
 makom9hR00+VZiRG8zBVtpKp1deusRQBYLynqInKjy6H6at3O20cmBGR57oyHExb8m0z
 dHKFox4iNLlRgfqnNJm0umGtJN3HwnnEojEkow1lnDn+/aHIayo0pVhDa5r+uROllD6q
 uyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931653; x=1795536453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTxkm52SwyWAxOw4MUfMiPQp1u3bD0l95fJGtaKJ6LY=;
 b=T6ssxmFg2/8lUDZp+jru3gYNZRK2VqAtojaA2DmNSFtWymErMwZ2Ijb2LMO7JebZuj
 iWtAlmP4sJfWUFV2ZEWTTDWNyo0wCpF6LS2FJShSFkgPexeq6lEGG55tb9eWmIbYP1cM
 ILgeStmge1iuXSDmrhUOqBPfBLNJFybMnyROl8EYhadBDMeQkWFv6Dwg06FyNvKtvbqT
 R1hORkxh4plUvFtKJpOwFyzeLv9bF7Ae9IyuNx/0o9nMUH84l+xUclVbhYBto7zmDBcZ
 9cJIUhitvrDMNHqAgDpQcpiCRLwjW1dNrzi+kbUUTclNefaw4eIU2GnLV7+OkQc2p0kw
 +IpA==
X-Gm-Message-State: APuU4Z/mrc3bKjNBpoQWBUe73uutGOE8euKkjJaOKQy7p8+0ZnzIfCrJ
 7e1tR9Y2zO0Y7ebTsoGtAmPkWO+NI/I3jMfB0qlO9hifUdqxl9407gYB6qo49cQU7q9IUsjspGx
 DeUMMQrQ=
X-Gm-Gg: AYBFou3GS9W1gsUy0CvSMAId0vmb3Vj8qdVhp/KGMZQStfRv2ywwnSNnk8yzcF8EB9d
 9+AhXZdxUZKTW0czD/QhhZ/xVYxAq7mKjv9dGIVufgqJ/hKyNmIlien2ptWlDG/Aaz93j7mkFUo
 NFw0gziEAPfCOd7n05kpp6QOazuYwC3+eIEXG8MCFs04+t8REbLQY7kzwtf82tK+/K13Nyu0NZ+
 oHIpm2rCaYF4iNMtT2NiQdUvn0BmUBJmdS8dbFRoc/9z5Wc6hQr2fOl3pJOF8x9SR9m32ghrIH/
 3UWzYSufzebQswdA2IDDnyk0o4VRyYIimny9DB1Wm0gmsjckbq6frfwrXLlJcH6Em5oDaUjE1RD
 1ZZP0urIP4MTRjlhvg+784O+rtXj+PzU9m3lXSPovrMUdR286mqMv1Jp1QxaTZHijRy4mCHDxAw
 05KPQdoDV9Je9+qan38aVOBQqh5wF/7nh615akPPnXSVv60xqmGVC8M1RdNKh6coCphEjYXumT+
 m0T6r6xNX36AMSQ9AhY2AH5vTwvmENECLeHkI8d2PIPYIcPNukAr2vfmNXRmycBmD8uUWKJM7xr
 5VGjjyiKhP1+G1q6Lk8ndbYfEbxP7BRjyQ4bqIzOCIoMfiSH7iSftq1uKhxWsJaW8eW8dDU=
X-Received: by 2002:a05:6a00:a13:b0:886:c8d1:632f with SMTP id
 d2e1a72fcca58-8beb724cecamr11495636b3a.42.1794931653409; 
 Tue, 17 Nov 2026 08:07:33 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5b40c3d33sm9403b3a.49.2026.11.17.08.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:07:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 2/4] app/dumpcap: fix capture duration
Date: Tue, 17 Nov 2026 08:06:20 -0800
Message-ID: <20261117160727.388470-3-stephen@networkplumber.org>
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

The capture duration was measured using time() which has
one second resolution and was compared with greater than,
so the capture could run up to a second longer than requested.
Also, since the duration was converted to whole seconds,
fractional durations were lost; a duration of less than one
second would be treated as no limit.

Use the TSC to measure the capture interval, as is done
in the rest of DPDK, and keep the fractional part of the
duration.

Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index c4790988e5..2808f77add 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -69,13 +69,13 @@ static bool print_stats;
 
 /* capture limit options */
 static struct {
-	time_t  duration;	/* seconds */
+	double  duration;	/* seconds */
 	unsigned long packets;  /* number of packets in file */
 	size_t size;		/* file size (bytes) */
 } stop;
 
 /* Running state */
-static time_t start_time;
+static uint64_t stop_tsc;	/* TSC when duration expires, 0 if none */
 static uint64_t packets_received;
 static size_t file_size;
 
@@ -1036,7 +1036,9 @@ int main(int argc, char **argv)
 	mp = create_mempool();
 	out = create_output();
 
-	start_time = time(NULL);
+	if (stop.duration > 0)
+		stop_tsc = rte_get_tsc_cycles() +
+			(uint64_t)(stop.duration * rte_get_tsc_hz());
 	enable_pdump(r, mp);
 
 	if (!quiet) {
@@ -1057,8 +1059,7 @@ int main(int argc, char **argv)
 		if (stop.packets && packets_received >= stop.packets)
 			break;
 
-		if (stop.duration != 0 &&
-		    time(NULL) - start_time > stop.duration)
+		if (stop_tsc != 0 && rte_get_tsc_cycles() >= stop_tsc)
 			break;
 	}
 
-- 
2.53.0

