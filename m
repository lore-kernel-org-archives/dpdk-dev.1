Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E9C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CCBF4069F;
	Mon,  7 Sep 2026 01:27:59 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id B66044069D
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:57 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so3524538a91.1
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737277;
 x=1789342077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HsAYpvmk8rr61N2cVYwJ9NTUq/YaUkhoNPcmprSw43Y=;
 b=jGzFKx+VALIe+xXiPwq21EmIDIX9wfcd1u21196cZojJv3AZy9Vhh8jgZfeZTA7/IG
 VPNGz8hYR4x1AJ1nyqc1lkdn7GKasjTdAE6SiGi2x2aT9mlhMXiFPk/SNe/fBsZK2QA/
 NPV4Aju93d/kw69HNyjK155pJKNWP6tB5XD+eDHixogUWZztwjg8U4zk77aMn8yeQj11
 05G4V3ioDGvvSDVGdCGzESI8nukvCk/pyd00Fs7h+mAQo55kGGE3bb5yueNql+FT6Ar7
 8hZBVOHAUSYS9pdeWrzVR9EhNh4TidBxkEhyCTNBfjffY9KEY/4VFNVK6QNLjMuKjpE3
 LrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737277; x=1789342077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HsAYpvmk8rr61N2cVYwJ9NTUq/YaUkhoNPcmprSw43Y=;
 b=G13rONpaUvR1CD1wy+9nDfDk6BEIaapdbFYqNy29X31lfGYRtjLaf6xgSaD7R3KpA6
 1O62cNYX4s3flzmNhHOAxkpW4CUjytCZbkvNth+5PBwNpBEDdfGnNPcx/w0bYtEiJ1hF
 tpkWfFc/W6pzAD4uT8fjKL3v+mRY3jbjCrGvXTdEVuj4+2f8Z0xX3/+xCwpLSs2dhulD
 FAf1h5624otGrGWSkOF/ENSwsuiwbxqgQPe7IDkrchCtV/Mnq8QVjZXDthhL/JmeDGvl
 WdGp/fbn8A1Zy80hvh2B7PpREdG7o8ikwOZaMp1ecnpxBYoJc+57uAknsXCj5W3qQpfu
 3YDg==
X-Gm-Message-State: AFuF++nukMYLYXB6N8wTN7bL1plto69MxxRlzscFEHUrIPzAeoF8ah56
 vaaCwoTIDJX51G/HR2lo7c/L+QUpvfacdhlCl9E1AQWXY8GDofVO5Trlx67mj5EZPh/InTPpYry
 LLhgT
X-Gm-Gg: AYBFou0py6Hdp3HVpdZRpisNZZt9UMAwOOclBLXblCVYfadfr4SMSDUf3SgDuz82ows
 dDxJs8IjSZhd+OSnvHRkkuhKs/DOW+a64e+cwHThNyXmTHXrjoJWS9W6BCcfy1v4jRrT824S6Fr
 HLpkVDiFnbi/VS/z8XUXZ5CGTFY8xW/vrJmcIyfmBYmjfJ/Yj260I2iF9LlptXgEP45OLzT+dBQ
 HSkrtMOP4LSEi1bCFjNj7Dmej2FcZzTPyQQVU0jsKkmSL2RmSbZaNFGrX80rxAeiHOQXz8inAGf
 uRw1uzJZOBjvOQIVBO9DfAg6XOSllJy5QTlh0vtxT8ng7B1P83lLh1AWiIRiMEsOSwkZs1Og02p
 DjsLp5es6kQEhFpw4jAzNG6m5ys0/ZqjdN7FH6mcML8fao8uqBwLdk27AWmaxwDlE/3Yn2GMIy5
 7xg6Su5IYRDo6shyV5nLO8jlo/Pm3u9Xsc0rFbDEVn1QJswmHi7JooamdAQf/xQhEd6o+JFDdKd
 x1xC7XHaVBSjb6E3UqBMTpZJYg=
X-Received: by 2002:a17:90b:1e51:b0:399:ecd:d68d with SMTP id
 98e67ed59e1d1-39b26260f7dmr27361101a91.22.1788737276911; 
 Sun, 06 Sep 2026 16:27:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 09/13] examples/ipsecgw: do not print from signal handler
Date: Sun,  6 Sep 2026 16:24:44 -0700
Message-ID: <20260906232716.496546-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

The SIGINT handler calls printf which is not async-signal safe.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ipsec-secgw/ipsec-secgw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index eba7560c9b..4816bcdd82 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -2448,11 +2448,8 @@ create_default_ipsec_flow(uint16_t port_id, uint64_t rx_offloads)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 static void
-- 
2.53.0

