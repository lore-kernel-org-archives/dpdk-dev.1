Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59462CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 18:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7011B4026D;
	Mon, 10 Nov 2025 19:22:18 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1FE0440655
 for <dev@dpdk.org>; Mon, 10 Nov 2025 19:22:17 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-29558061c68so40466185ad.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762798936;
 x=1763403736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LptPlSMiLcrnBm7MdWvcF7UrvDAdR36h7sf0n/TbYaQ=;
 b=yF5G8Hu5gk77HxTle7n4lf7aQ1iYveT+Z+TEP+gnYVe7KPJRu0KuZNmHq+M/exutCx
 6SLw5RjkzEKVrYwz/XwpiZlJkvQ/g5ZaZXgoa1QtBE80lw+1ydJhmUASHdosb/pzzj6k
 kogR9IYNwB9Rm0mNWo/imyQQflbXcfxaLU2C7+pCqbDDsC6J1DBw7+x3gOZ76oypQZNO
 ldczmd/HqXPGpKFKAonUJ4FBd8PTU4/gnxkRYqWNbtLd1WoIyxu/tcaWqunxdxuSBug8
 GaxKzIJp7OYQfvqb/a8FA9sZ16Bv0YdMb5nRv2mgB9YA9xYguZvKoCvZ2OhYVdmxvyM8
 vUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762798936; x=1763403736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LptPlSMiLcrnBm7MdWvcF7UrvDAdR36h7sf0n/TbYaQ=;
 b=tV4K44O0Lr+G+jFs2IRUvSjTAvTQpU2CX5zFjOigN47f6+7xxMij3dLbT/SJluJekb
 SPbaDEdQQD5M3FePv9bTkF1bsfo9o0jEPl0TJ/82ZCX4csoaCKJwz8EcgB11ryIMLOla
 8rAsM1pOvAUP2SKAZA3VjmllP7WVwFZvlx3Q+XGZvbx17dHggg2KyNfDpC43jxFsf5GB
 DLcU+HCKyAYqN4DSvmoHjKAr7evOytOHNTRYQJppMXoTjQG48PGVtFamkrIKIDemmODN
 4nN2l13g9OKF3ja6IFarh/kQydABSEfCtGyOgm+1OYjo/JFw2pGVYOs7FjatWLL953yW
 +niw==
X-Gm-Message-State: AOJu0Yyn6ouT3cxMPRdTOY+mGAyt9T9DWiLtEM0yJQGdHxQ77jEm31fN
 5sjC3vAHuyXa7dt+eyd+YlOdSepXi9AmxpJU+d1CtocJyOggNrNa2s/i/1TnTvqloNHbU+FdlwN
 oNbEg
X-Gm-Gg: ASbGncs/GF2aC9JdABDeuQlVsLeqf0GAotiZtA/eYtI7x/rhRH32g8noafz5kr56M5S
 Nk63KNwpsKNgy/hPKHGN/b2pk0lKDGXqM4mzRk76OlemByg9cV1xsb/QHDqWtZ5hwkRl8Gph+6W
 eHsxQZnuip51NGtFNTvnC0XbdYHSSN8athl7L4ROf+nC163RPIFbm5Z1OeFG3Q8Ck2v6l/tPLhe
 AnMA1fPrkZgCLyxL6zFqjDFzuyeVBnwIA87AXgfap6Zqr70tWESQLn3y1GwLkkux3eRg73Pp4hr
 Dt1M3o1TM+/VkkMARwHGyQuPkrenUQYe7F7X2X5zm4qqYyv4WvHhgb8qmvolaT/IqOMwetgWPrN
 S0CDqknpq3klcJlHeNIg/8xlv12G13RubI5y9aijyZUs+Uu4PJk77Uh7kMTSM2nm697d8vNFyZa
 jHeOoJDaGX5+tx6X5W98s942ZEEp+zLu9ex457vCE=
X-Google-Smtp-Source: AGHT+IEHsQ8U/6nMUtIh7EgkNNuAPwaUPgXp07PLCfUSqkB0kGhvE+M5QaxNmx1sALk0UF33L2cMmw==
X-Received: by 2002:a17:903:41d2:b0:297:c0f0:42a1 with SMTP id
 d9443c01a7336-297e56d0d34mr116549995ad.44.1762798936230; 
 Mon, 10 Nov 2025 10:22:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650968298sm156290405ad.6.2025.11.10.10.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:22:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 3/3] examples: re-enable format truncation warning
Date: Mon, 10 Nov 2025 10:19:35 -0800
Message-ID: <20251110182209.104087-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

There were several hidden bugs in examples because format
truncation warning was disabled.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..25d9c88457 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -78,10 +78,9 @@ else
     examples = get_option('examples').split(',')
     allow_skips = false # error out if we can't build a requested app
 endif
+
 default_cflags = machine_args
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
+
 default_ldflags = dpdk_extra_ldflags
 if get_option('default_library') == 'static' and not is_windows
     default_ldflags += ['-Wl,--export-dynamic']
-- 
2.51.0

